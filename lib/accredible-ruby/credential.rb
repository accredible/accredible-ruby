module Accredible
  class Credential
    attr_reader :url

    def self.view(id = nil)
      uri = Credential.api_end_point(id)
      Accredible.request(uri) 
    end

    def self.create(recipient:, credential:, evidence: {}, references: {})
      params = Util.build_credential_params(recipient, credential, evidence, references)
      uri = Accredible.api_url
      Accredible.request(uri, :post, params)
    end

    def self.update(achievement_id:, credential: {})
      uri =  Credential.api_end_point(achievement_id)
      params = {credential: credential}.to_json
      Accredible.request(uri, :put, params)
    end

    def self.delete(achievement_id)
      uri =  Credential.api_end_point(achievement_id)
      Accredible.request(uri, :delete)
    end

    def self.view_all(achievement_id, email)
      uri = Credential.view_all_end_point(achievement_id, email)
      Accredible.request(uri)
    end

    def self.api_end_point(id = nil)
      @url = Accredible.api_url("credentials/#{id}")
    end

    def self.view_all_end_point(achievement_id, email)
      @view_all_url = Accredible.api_url("credentials?achievement_id=#{achievement_id}&email=#{email}")
    end
  end
end
