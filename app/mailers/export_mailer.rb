class ExportMailer < ApplicationMailer

  def export_email(email, type, file)
    @email = email
    attachments["#{File.basename file}"] = File.read(file)
    mail(to: @email, subject: "#{type.capitalize} export from MAFN site")
  end

end
