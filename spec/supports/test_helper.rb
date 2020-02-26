# spec/supports/test_helper.rb
module TestHelper
  
  #ユーザー登録する
  def signup_as(user)
      visit signup_path
      fill_in "ユーザー名", with: user.name
      fill_in "アカウントID", with: user.unique_name
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password.to_s
      fill_in "パスワード（確認）", with: user.password.to_s
      click_button "登録"
  end
    
  # ログインする
  def login_as(user, options = {})
    remember_me = options[:remember_me] || '1'
      visit login_path
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: 'password'
      if remember_me == '1'
        check "パスワードを保存する"
      end
      click_button 'ログイン'
  end

  def logout
      click_link "アカウント"
      click_link 'ログアウト'
  end
  
  def is_logged_in?
    !session[:user_id].nil?
  end
end