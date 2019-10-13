module LoginSupport
  def sign_in_as(user)
    visit '/login'
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"
  end
end
