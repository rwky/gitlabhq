class EmailRejectionMailer < BaseMailer
  def rejection(reason, original_raw, can_retry = false)
    @reason = reason
    @original_message = Mail::Message.new(original_raw)

    headers = {
      to: @original_message.from,
      subject: "[Rejected] #{@original_message.subject}"
    }

    headers['Message-ID'] = SecureRandom.hex
    headers['In-Reply-To'] = @original_message.message_id
    headers['References'] = @original_message.message_id

    headers['Reply-To'] = @original_message.to.first if can_retry

    mail(headers)
  end
end