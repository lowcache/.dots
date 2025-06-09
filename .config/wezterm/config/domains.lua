local platform = require('utils.platform')
if platform.is_win then
   return
end
if platform.is_linux then
   return{
      ssh_domains = {},
      unix_domains = {},
      wsl_domains = {},
   }
end
if platform.is_mac then
   return
end
