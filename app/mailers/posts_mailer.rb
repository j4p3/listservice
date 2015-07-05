class PostsMailer < ApplicationMailer
  def post_create(post)
    mandrill = Mandrill::API.new Listservice::Application.config.email.api_key
    message = {
      'text' => generate_email(post),
      'to' => [{
        'name' => post.author,
        'email' => post.email
      }, {
        'email' => 'bonnerjp@gmail.com',
        'type' => 'bcc'
      }],
      'from_name' => 'JP',
      'from_email' => 'bonnerjp@gmail.com',
      'subject' => 'Saved your listserve email!'
    }
    result = mandrill.messages.send message
  end

  private

  def generate_email(post)
    "Hey #{post.author}! Looks like your Listserve email is live. Congrats!\n\nJust wanted to let you know it's been automatically archived at http://thelistserves.com/posts/#{post.friendly_id}.\n\nCheck it out, share it with your friends who aren't on the Listerve, and enjoy your day in the spotlight :)\n\n- JP"
  end
end
