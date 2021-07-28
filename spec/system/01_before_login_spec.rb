require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  let(:user) { create(:user) }
   
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'LogInリンクが表示される: 左上から5番目のリンクが「LogIn」である' do
        LogIn_link = find_all('a')[5].native.inner_text
        expect(LogIn_link).to match(/login/i)
      end
      it 'LogInリンクの内容が正しい' do
        LogIn_link = find_all('a')[5].native.inner_text
        expect(page).to have_link LogIn_link, href: new_user_session_path
      end
      it 'SignUpリンクが表示される: 左上から4番目のリンクが「SignUp」である' do
        SignUp_link = find_all('a')[4].native.inner_text
        expect(SignUp_link).to match(/signup/i)
      end
      it 'SignUpリンクの内容が正しい' do
        SignUp_link = find_all('a')[4].native.inner_text
        expect(page).to have_link SignUp_link, href: new_user_registration_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      # it 'Homeリンクが表示される: 左上から1番目のリンクが「HAPPYDOG」である' do
      #   home_link = find_all('a')[1].native.inner_text
      #   expect(home_link).to match(/home/i)
      # end
      it 'PostIndexリンクが表示される: 左上から2番目のリンクが「PostIndex」である' do
        PostIndex_link = find_all('a')[2].native.inner_text
        expect(PostIndex_link).to match(/posts/i)
      end
      it 'Aboutリンクが表示される: 左上から3番目のリンクが「About」である' do
        About_link = find_all('a')[2].native.inner_text
        expect(About_link).to match(/about/i)
      end
      it 'SignUpリンクが表示される: 左上から4番目のリンクが「SignUp」である' do
        SignUp_link = find_all('a')[4].native.inner_text
        expect(SignUp_link).to match(/signup/i)
      end
      it 'LogInリンクが表示される: 左上から5番目のリンクが「LogIn」である' do
        LogIn_link = find_all('a')[5].native.inner_text
        expect(LogIn_link).to match(/login/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      # it 'HAPPYDOGを押すと、トップ画面に遷移する' do
      #   home_link = find_all('a')[1].native.inner_text
      #   home_link = home_link.delete(' ')
      #   home_link.gsub!(/\n/, '')
      #   click_link home_link
      #   is_expected.to eq '/'
      # end
      it 'Aboutを押すと、アバウト画面に遷移する' do
        About_link = find_all('a')[3].native.inner_text
        About_link = About_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link About_link
        is_expected.to eq '/about'
      end
      it 'SignUpを押すと、新規登録画面に遷移する' do
        SignUp_link = find_all('a')[4].native.inner_text
        SignUp_link = SignUp_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link SignUp_link
        is_expected.to eq '/users/sign_up'
      end
      it 'LogInを押すと、ログイン画面に遷移する' do
        LogIn_link = find_all('a')[5].native.inner_text
        LogIn_link = LogIn_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link LogIn_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'SignUpボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「Log in」と表示される' do
        expect(page).to have_content 'Log in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end
    end 
  end 
end