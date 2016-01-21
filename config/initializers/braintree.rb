Braintree::Configuration.environment = Figaro.env.bt_env || :sandbox
Braintree::Configuration.merchant_id = Figaro.env.bt_merchant_id
Braintree::Configuration.public_key  = Figaro.env.bt_public_key
Braintree::Configuration.private_key = Figaro.env.bt_private_key
