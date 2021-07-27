require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    describe 'ヘッダーのテスト: ログインしている場合' do
      context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
        subject { current_path }

        it 'PostIndexを押すと、投稿一覧画面に遷移する' do
          PostIndex_link = find_all('a')[1].native.inner_text
          PostIndex_link = PostIndex_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link PostIndex_link
          is_expected.to eq '/posts/'
        end

        it 'PostNewを押すと、投稿画面に遷移する' do
          PostNew_link = find_all('a')[2].native.inner_text
          PostNew_link = PostNew_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link PostNew_link
          is_expected.to eq '/posts/new'
        end

        it 'UserINdexを押すと、user一覧画面に遷移する' do
          UserIndex_link = find_all('a')[3].native.inner_text
          UserIndex_link = userindex_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link UserIndex_link
          is_expected.to eq '/users'
        end

        it 'MyPageを押すと、user詳細画面に遷移する' do
          MyPage_link = find_all('a')[3].native.inner_text
          MyPage_link = MyPage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link MyPage_link
          is_expected.to eq '/users'+ user.id.to_s
        end

        end
        it 'MyDogを押すと、userのdog一覧+New画面に遷移する' do
          MyDog_link = find_all('a')[3].native.inner_text
          MyDog_link = MyDog_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link MyDog_link
          is_expected.to eq '/dogs' + user.dog.id.to_s
        end
      end
    end

    describe '投稿一覧画面のテスト' do
      before do
        visit posts_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/posts'
        end
        it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
          expect(page).to have_link post.place, href: post_path(post)
          expect(page).to have_link other_post.place, href: post_path(other_post)
        end
        it '自分の投稿と他人の投稿のイントロダクションが表示される' do
          expect(page).to have_content post.introduction
          expect(page).to have_content other_post.introduction
        end
      end


    describe '自分の投稿詳細画面のテスト' do
      before do
        visit post_path(post)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/posts/' + post.id.to_s
        end
        it 'ユーザ画像・名前のリンク先が正しい' do
          expect(page).to have_link book.user.name, href: user_path(post.user)
        end
        it '投稿のplaceが表示される' do
          expect(page).to have_content post.place
        end
        it '投稿のアドレスが表示される' do
          expect(page).to have_content post.address
        end
        it '投稿の編集リンクが表示される' do
          expect(page).to have_link '投稿編集', href: edit_post_path(post)
        end

        it "緯度のフォ-ムが表示されるか"
        it "newの時のdefaultの値が正しいか" do
          expect(フォームの値をとる).to eq(default_value)
        end

        it "数字だけか"

        it '投稿の削除リンクが表示される' do
          expect(page).to have_link '投稿削除', href: post_path(post)
        end

        context '編集リンクのテスト' do
          it '編集画面に遷移する' do
            click_link '投稿編集'
            expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
          end
        end

        context '削除リンクのテスト' do
          before do
            click_link '投稿削除'
          end

          it '正しく削除される' do
            expect(Post.where(id: post.id).count).to eq 0
          end
          it 'リダイレクト先が、投稿一覧画面になっている' do
            expect(current_path).to eq '/posts'
          end
        end
      end
    end

    describe '新規投稿画面のテスト' do
      before do
        visit new_post_path
      end

      it '「新規投稿フォーム」と表示される' do
        expect(page).to have_content '新規投稿フォーム'
      end
      it 'placeフォームが表示される' do
        expect(page).to have_field 'post[place]'
      end
      it 'placeフォームに値が入っていない' do
        expect(find_field('post[place]').text).to be_blank
      end
      it '住所フォームが表示される' do
        expect(page).to have_field 'post[address]'
      end
      it '住所フォームに値が入っていない' do
        expect(find_field('post[address]').text).to be_blank
      end
      it '説明フォームが表示される' do
        expect(page).to have_field 'post[introduction]'
      end
      it '説明フォームに値が入っていない' do
        expect(find_field('post[introduction]').text).to be_blank
      end
      it '利用可能size' do
        expect(page).to have_field 'post[dog_size]'
      end
      it '利用可能size' do
        expect(find_field('post[dog_size]').text).to eq(0)
      end

      it '新規投稿ボタンが表示される' do
        expect(page).to have_button '新規投稿'
      end


      context '投稿成功のテスト' do
        before do
          fill_in 'post[place]', with: Faker::Lorem.characters(number: 5)
          fill_in 'post[address]', with: Faker::Lorem.characters(number: 20)
          fill_in 'post[introduction]', with: Faker::Lorem.characters(number: 20)
        end

        it '自分の新しい投稿が正しく保存される' do
          expect { click_button '新規投稿' }.to change(user.posts, :count).by(1)
        end
      end
    end

    describe '投稿編集画面のテスト' do
      before do
        visit edit_post_path(post)
      end

      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
        end
        it '「投稿編集フォーム」と表示される' do
          expect(page).to have_content '投稿編集フォーム'
        end
        it 'place編集フォームが表示される' do
          expect(page).to have_field 'post[place]', with: post.place
        end
        it '住所編集フォームが表示される' do
          expect(page).to have_field 'post[address]', with: post.address
        end
        it '説明編集フォームが表示される' do
          expect(page).to have_field 'post[introduction]', with: post.introduction
        end
        it '投稿編集ボタンが表示される' do
          expect(page).to have_button '投稿編集'
        end

        context '編集成功のテスト' do
          before do
            @post_old_place = post.place
            @post_old_address = post.address
            @post_old_introduction = post.introduction
            @post_old_dog_size = post.dog_size
            fill_in 'post[place]', with: Faker::Lorem.characters(number: 4)
            fill_in 'post[address]', with: Faker::Lorem.characters(number: 19)
            fill_in 'post[introduction]', with: Faker::Lorem.characters(number: 19)
            fill_in 'post[dog_size]', with: 0
            click_button '投稿編集'
          end


        it 'placeが正しく更新される' do
          expect(post.reload.place).not_to eq @post_old_place
        end
        it '住所が正しく更新される' do
          expect(post.reload.address).not_to eq @post_old_address
        end
        it '説明が正しく更新される' do
          expect(post.reload.introduction).not_to eq @post_old_introduction
        end

        it "緯度経度が更新されるか"
        it "数字か"

        it '利用可能size' do
          expect(post.reload.dog_size).include?(0123)
        end

        it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
          expect(current_path).to eq '/posts/' + post.id.to_s
        end
      end
    end
  end
end