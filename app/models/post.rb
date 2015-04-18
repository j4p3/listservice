class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: :slugged

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
      'all' => where("sent_date < ?", Date.today)
    }
    span_map[span] || span_map[:all]
  end
end
