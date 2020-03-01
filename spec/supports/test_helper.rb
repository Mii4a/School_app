# spec/supports/test_helper.rb
module TestHelper
  include SessionsHelper
  
  
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  #Request Spec
  #ログイン
  def request_login_as(user, option={})
    remember_me = option[:remember_me] || "1"
    get login_path
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    }
    follow_redirect!
  end
  
  #無効な設定で更新する
  def patch_invalid_information
    patch user_path(user), params: {
          user: {
            name:                  "",
            unique_name:           "",
            email:                 "foo@invalid",
            password:              "foo",
            password_confirmation: "bar"
          }
        }
  end
  
  #有効な設定で更新する
  def patch_valid_information
    name = "Foo Bar"
    unique_name = "foobar"
    email = "foo@bar.com"
    patch user_path(user), params: {
      user: {
        name: name,
        unique_name: unique_name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    }
  end
  
  #System Spec
  #ユーザー登録する
  def system_signup_as(user)
      visit signup_path
      fill_in "ユーザー名", with: user.name
      fill_in "アカウントID", with: user.unique_name
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "パスワード（確認）", with: user.password
      click_button "保存する"
  end
  
  # アカウントを有効化する
  def system_activate(user, id = {}, options = {})
    id = id[:id] || 1
    user.activation_token ||= options[:activation_token]
    user.email ||= options[:email]
    visit edit_account_activation_path(user.activation_token,
                                       email: user.email,
                                       id: id)
  end
    
  # ログインする
  def system_login_as(user, options = {})
    remember_me = options[:remember_me] || '1'
      visit login_path
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: 'password'
      if remember_me == '1'
        check "パスワードを保存する"
      end
      click_button 'ログイン'
  end

  #ログアウトする
  def system_logout
      click_link "アカウント"
      click_link 'ログアウト'
  end
  

end