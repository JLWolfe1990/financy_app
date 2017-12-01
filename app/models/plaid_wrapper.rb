class PlaidWrapper
  def self.client
    Plaid::Client.new(
      env: :development,
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'],
      public_key: ENV['PLAID_PUBLIC_KEY']
    )
  end
end