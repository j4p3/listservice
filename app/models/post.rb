require 'mandrill'

class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: :slugged
  after_create :email_notice

  default_scope { order(sent_date: :desc) }
  filterrific(
  default_filter_params: { mode: 'chron', span: 'all' },
  available_filters: [
    :search,
    :mode,
    :span
  ])

  # select options
  def self.options_for_mode
    [['Chronological', 'chron'], ['Popularity', 'pop']]
  end

  def self.options_for_span
    [['Day', 'day'], ['Week', 'week'], ['Month', 'month'], ['Year', 'year'], ['All', 'all']]
  end

  # scopes
  def self.search(query)
    where('body LIKE ? OR subject LIKE ? OR author LIKE ?', "% #{query} %", "%#{query}%", "%#{query}%")
  end

  def self.mode(mode)
    mode_map = {
      chron: unscoped.order(sent_date: :desc),
      pop: unscoped.order(sent_date: :desc)
      # pop: order('acts_as_disqusable.comments_count')
    }
    mode_map[mode] || mode_map[:chron]
  end

  def self.span(span)
    span_map = {
      'day' => where("sent_date > ?", Date.today - 1.day),
      'week' => where("sent_date > ?", Date.today - 1.week),
      'month' => where("sent_date > ?", Date.today - 1.month),
      'year' => where("sent_date > ?", Date.today - 1.year),
      'all' => where("sent_date < ?", Date.tomorrow)
    }
    span_map[span] || span_map[:all]
  end

  private

  def email_notice
    mandrill = Mandrill::API.new Listservice::Application.config.email.api_key
    message = {
      'text' => generated_email,
      'to' => [{
        'name' => self.author,
        'email' => self.email
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

  def generated_email
    "Hey #{self.author}! Looks like your Listserve email is live. Congrats!\n\nJust wanted to let you know it's been automatically archived at http://thelistserves.com/posts/#{self.friendly_id}.\n\nCheck it out, share it with your friends who aren't on the Listerve, and enjoy your day in the spotlight :)\n\n- JP"
  end
end
