require 'gibbon' # Importing gem to interact with mailchimp api

class MailchimpService
  def initialize
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_KEY'])
    @list_id = ENV['MAILCHIMP_ID']
  end

  def subscribe(email)
    @gibbon.lists(@list_id).members.create(
      body: {
        email_address: email,
        status: "subscribed"
      }
    )
  rescue Gibbon::MailChimpError => e # executed if there is an error
    puts "Error: #{e.message}"
  end

  def unsubscribe(email)
    hashed_email = Digest::MD5.hexdigest(email.downcase) # converts email to lowercase and places them into a hash to perform actions
    @gibbon.lists(@list_id).members(hashed_email).update(
      body: {
        status: "unsubscribed"
      }
    )
  rescue Gibbon::MailChimpError => e
    puts "Error: #{e.message}"
  end
end
