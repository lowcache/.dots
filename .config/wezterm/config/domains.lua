local platform = require
('utils.platform')
if platform.is_win then
   return {
      -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
      -- ssh_domains = {},
  
       ssh_domains = {
         -- yazi's image preview on Windows will only work if launched via ssh from WSL
         {
            name = 'wsl.ssh',
            remote_address = 'localhost',
            multiplexing = 'None',
            default_prog = { 'fish', '-l' },
            assume_shell = 'Posix'
         }
      },

      -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
      unix_domains = {},

      -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
  
       wsl_domains = {
         {
            name = 'WSL:Ubuntu',
            distribution = 'Ubuntu',
            username = 'kevin',
            default_cwd = '/home/$USER',
            default_prog = { 'fish', '-l' },
         },
      },
   }
end
if platform.is_linux then
   return{
      ssh_domains = {},
      unix_domains = {},
      wsl_domains = {},
   }
end
if platform.is_mac then
   return{
      ssh_domains = {},
      unix_domains = {},
      wsl_domains = {},
   }
end
