import subprocess
import re
import os

def check_adb():
    try:
        subprocess.run(['adb', 'devices'], check=True)
        return True
    except subprocess.CalledProcessError:
        print("Error: ADB is not installed. Please install with: sudo pacman -S android-tools")
        return False

def check_device():
    result = subprocess.check_output(['adb', 'devices']).decode()
    if "List" in result or result.strip() == "":
        print("No Android device detected. Please connect your phone via USB.")
        return False
    elif len(result.split('\n')) > 2:
        print("Multiple devices detected. Please disconnect other devices.")
        subprocess.run(['adb', 'devices'])
        return False
    return True

def enable_tethering():
    [ subprocess.run(['adb', 'shell', 'settings', 'put', 'global', 'teher_dun_required', '0'])
    subprocess.run(['adb', 'shell', 'svc', 'usb', 'setFunctions', 'rndis'])
    subprocess.run(['adb', 'shell', 'settings', 'put', 'global', 'teher_offload_disabled', '0'])


def optimize_tcp():
    subprocess.run(['sysctl', '-w', 'net.core.rmem_max=16777216'])
    subprocess.run(['sysctl', '-w', 'net.core.wmem_max=16777216'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_rmem=4096 87380 16777216'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_wmem=4096 65536 16777216'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_window_scaling=1'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_fastopen=3'])
    available_cc = subprocess.check_output(['sysctl', 'net.ipv4.tcp_available_congestion_control']).decode().split
('=')[1].strip()
    if 'br' in available_cc:
        subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_congestion_control=bbr'])
    elif 'cubi' in available_cc:
        subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_congestion_control=cubic'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_timestamps=1'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_sack=1'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_thin_lear_timeouts=1'])
    subprocess.run(['sysctl', '-w', 'net.ipv4.tcp_early_retrans=1'])

def optimize_mtu(iface):
    current_mtu = int(subprocess.check_output(['ip', 'link', 'show', iface]).decode().split('mtu ')[1].split()[0])
    mtu_sizes = [1500, 1472, 1452, 1440, 1420, 1400]
    best_mtu = current_mtu
    best_time = 99999
    for mtu in mtu_sizes:
        subprocess.run(['ip', 'link', 'set', 'dev', iface, 'mtu', str(mtu)])
        ping_result = subprocess.run(['ping', '-c', '3', '-s', str(mtu - 28), '8.8.8.8'], capture_output=True, text
=True).stdout
        if '100%' not in ping_result:
            time = float(re.search(r'avg\/(\d+\.\d+)', ping_result).group(1))
            if time < best_time:
                best_time = time
                best_mtu = mtu
    subprocess.run(['ip', 'link', 'set', 'dev', iface, 'mtu', str(best_mtu)])

def disable_usb_power_management(iface):
    subprocess.run(['echo', '-1', '>', '/sys/module/usbcore/parameters/autosuspend'])
    for device in os.listdir('/sys/bus/usb/devices/*/power/control'):
        subprocess.run(['echo', 'on', '>', f'/sys/bus/usb/devices/{device}/power/control'])
    usb_path = subprocess.check_output(['find', '/sys/class/net/' + iface + '/device/driver/module', '-type', 'l',
 '-name', 'usb*']).decode().strip()
    if usb_path:
        subprocess.run(['echo', 'on', '>', f'{usb_path}/power/control'])

def main():
    if check_adb():
        if check_device():
            enable_tethering()
            optimize_tcp()
            disable_usb_power_manag
