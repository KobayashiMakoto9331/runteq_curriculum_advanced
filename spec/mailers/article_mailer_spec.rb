require "rails_helper"

RSpec.describe ArticleMailer, type: :mailer do
  describe "report_summary" do
    let(:mail) { ArticleMailer.report_summary }

    it "renders the headers" do
      expect(mail.subject).to eq("Report summary")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
