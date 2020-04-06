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
  
  # パスワードをリセットする
  def request_password_reset(user, options = {})
    email = options[:email] || user.email
    post password_resets_path, params: { password_reset: { email: email } }
  end
  
  # パスワードを更新する
  def request_patch_new_password(user, options={})
    password = options[:password] || "foobar"
    password_confirmation = options[:password_confirmation] || password
    patch password_reset_path(user.reset_token), 
    params: { email: user.email,
               user: { password: password,
                       password_confirmation: password_confirmation } }
  end
  
  # 学校を作る
  def request_create_school(user)
    post schools_path, params: {
      school: {
        sub_title: "テストデータ",
        name: "テストデータ学園",
        content: "テストデータ",
        user_id: user.id
      }
    }
  end
  
  # SchoolChatを投稿
  def request_create_chat(user, school, content="テストデータ")
    post school_chats_path, params: {
      school_chat: {
        user_id: user.id,
        school_id: school.id,
        content: content
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
  def system_login_as(user)
      visit login_path
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: 'password'
      click_button "ログイン"
  end

  #ログアウトする
  def system_logout
      click_on 'ログアウト'
  end
  
  # 学校を作る
  def system_school_create(options={})
    name = options[:name] || "School"
    sub_title = options[:sub_title] || "sub_title"
    content = options[:content] || "content"
    visit root_path
    click_link "学校を作る"
    fill_in "学校名", with: name
    fill_in "サブタイトル", with: sub_title
    fill_in "学校について", with: content
    # attach_file "学校写真", "../imgs/school.jpeg"
    click_button "提出する"
  end
  
  # 学校を削除する
  def system_school_destroy
    find(".school-dropdown_trigger").click
    click_on "削除"
  end
  
  # 学校の内容を更新する
  def system_school_update(options={})
    name = options[:name] || name
    sub_title = options[:sub_title] || "sub_title"
    content = options[:content] || "content"
    visit edit_school_path(user)
    fill_in "学校名", with: name
    fill_in "サブタイトル", with: sub_title
    fill_in "学校について", with: content
    click_button "再提出する"
  end
  
  # SchoolChatを作成する
  def system_school_chat_create(user, school, content="test chat")
    system_login_as(user)
    visit school_path(school)
    fill_in "コメント", with: content
    click_on "投稿する"
  end
  
  def system_school_chat_destroy(user, school)
    find(".chat-dropdown_trigger").click
    click_on '削除'
  end
    
  def ensure_browser_size(width = 1200, height = 720)
    Capybara.current_session.driver.browser.manage.window.resize(width, height)
  end
    
end