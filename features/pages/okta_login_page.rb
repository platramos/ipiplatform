class OktaLoginPage < Page
 PATH = "/auth/saml/"

 def initialize(page)
    @page = page
 end

  def navigate
    @page.visit(PATH)
  end
end
