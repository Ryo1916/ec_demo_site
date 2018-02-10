Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1981663805416625', '78ba52f838b80fda01af998f08c422b9'
  provider :twitter, "3w5jwKQtvBRuNkblrDHlcdBuv", "iAVmOog87vD5i3HDFUV8E5pwdWyVawo3VIah5s5HoB10QKGU9q"
  provider :google_oauth2, "665739657674-ctvv9v6fca2kcr4k5aguifqt0b4qpa7u.apps.googleusercontent.com", "_P58relSrCDQmWnN4UucPGPh"
end
