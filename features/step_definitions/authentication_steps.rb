Given /^ユーザーがサインインページを訪問する$/ do
  visit signin_path
end

When /^彼が無効な情報でサインインボタンを押す$/ do
  click_button "Sign in"
end

Then /^彼はエラーメッセージを見る$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^ユーザーはアカウントを持っている$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
    password: "foobar", password_confirmation: "foobar")
end

When /^彼が有効な情報でサインインボタンを押す$/ do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then /^彼は彼のプロフィールページを見る$/ do
  page.should have_selector('title', text: @user.name)
end

Then /^彼はサインアウトのリンクを見る$/ do
  page.should have_link('Sign out', href: signout_path)
end
