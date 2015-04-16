class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: :slugged

  default_scope { order(date: :asc) }
  filterrific(
  default_filter_params: { mode: 'chron', span: 'month' },
  available_filters: [
    :search,
    :mode,
    :span
  ])

  # select options
  def self.options_for_mode
    [['Popularity', 'pop'], ['Chronological', 'chron']]
  end

  def self.options_for_span
    [['Day', 'day'], ['Week', 'week'], ['Month', 'month'], ['Year', 'year'], ['All', 'all']]
  end

  # scopes
  def self.search(query)
    where('body LIKE ? OR subject LIKE ? OR author LIKE ?', "% #{query} %", "% #{query} %", "% #{query} %")
  end

  def self.mode(mode)
    mode_map = {
      chron: unscoped.order(date: :asc),
      pop: unscoped.order(date: :asc)
      # pop: order('acts_as_disqusable.comments_count')
    }
    mode_map[mode] || mode_map[:chron]
  end

  def self.span(span)
    span_map = {
      'day' => where("date > ?", DateTime.now - 1.day),
      'week' => where("date > ?", DateTime.now - 1.week),
      'month' => where("date > ?", DateTime.now - 1.month),
      'year' => where("date > ?", DateTime.now - 1.year),
      'all' => where("date < ?", DateTime.now)
    }
    span_map[span] || span_map[:all]
  end
end
