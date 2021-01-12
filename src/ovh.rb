class Channel::Driver::Sms::Ovh
  NAME = "sms/ovh".freeze

  def fetchable?(_channel)
    false
  end

  def send(options, attr, _notification = false)
    Rails.logger.info "Sending SMS to recipient #{attr[:recipient]}"

    return true if Setting.get("import_mode")

    Rails.logger.info "Backend sending OVH SMS to #{attr[:recipient]}"

    return if Setting.get("developer_mode")

    response = perform_request(options, attr)
    JSON.parse(response.body)
  rescue Faraday::Error, JSON::ParserError => e
    Rails.logger.debug "OVH error: #{e.inspect}"
    raise e
  end

  def self.definition
    {
      name: "ovh",
      adapter: "sms/ovh",
      notification: [
        { name: "options::gateway", display: "Gateway", tag: "input", type: "text", limit: 200, null: false, placeholder: "https://www.ovh.com/cgi-bin/sms/http2sms.cgi", default: "https://www.ovh.com/cgi-bin/sms/http2sms.cgi" },
        { name: "options::account", display: "Account", tag: "input", type: "text", limit: 200, null: false, placeholder: "sms-XXXXXX-X" },
        { name: "options::sender", display: "Sender", tag: "input", type: "text", limit: 200, null: false, placeholder: "XXXXX" },
        { name: "options::login", display: "Login", tag: "input", type: "text", limit: 200, null: false, placeholder: "XXXXX"  },
        { name: "options::password", display: "Password", tag: "input", type: "password", limit: 200, null: false, placeholder: "XXXXX" }
      ]
    }
  end

  private

  def perform_request(options, attr)
    options[:to] = attr[:recipient]
    options[:message] = attr[:message]
    Faraday.get(options[:gateway], request_params(options))
  end

  def request_params(options)
    {
      account: options[:account],
      from: options[:sender],
      to: options[:to],
      login: options[:login],
      message: options[:message],
      password: options[:password],
      contentType: "application/json"
    }
  end
end
