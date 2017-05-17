class PushNotification < ApplicationRecord
  belongs_to :user
  after_create :upload_notification_to_ionic

  validates :message, presence: true
  validates :tokens, presence: true

  # attribute :tokens, :string, array: true
  serialize :tokens, Array
  serialize :sent_to, Array

private
  def upload_notification_to_ionic
    puts self.tokens.to_json

   badge_count = Conversation.where('(recipient_id= ? AND recipient_read= false) OR (sender_id= ? AND sender_read= false)', self.sent_to, self.sent_to).count;

    params = {
      "tokens" => self.tokens,
      "profile" => ENV['IONIC_PUSH_ENV'],
      "notification":{
        "payload": {
          "user_message": "0"
        },
        "message": self.message,
        "android":{
          "title": "Crescent Ford",
          "sound": "true"
        },
         "ios": {
              "title": "Crescent Ford",
              "sound": "true",
              "badge": badge_count
            }
      }
    }

    uri = URI.parse('https://api.ionic.io/push/notifications')
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req['Authorization'] = ENV['IONIC_API_TOKEN']
    req['Content-Type'] = 'application/json'
    req.body = params.to_json
    res = https.request(req)
    puts res.body
  end
end
