class Post < ActiveRecord::Base
  default_scope { order(date: :asc) }
  filterrific(
  default_filter_params: { mode: 'pop', span: 'month' },
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
    where('body LIKE ?', query)
  end

  def self.mode(mode)
    mode_map = {
      chron: unscoped.order(date: :asc),
      pop: unscoped.order('acts_as_disqusable.comments_count')
    }
    unscoped
  end

  def self.span(span)
    span_map = {
      'day' => where("date > ?", DateTime.now - 1.day),
      'week' => where("date > ?", DateTime.now - 1.week),
      'month' => where("date > ?", DateTime.now - 1.month),
      'year' => where("date > ?", DateTime.now - 1.year),
      'all' => unscoped
    }
    span_map[span] || span_map[:all]
  end
end
