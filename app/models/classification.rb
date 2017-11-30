class Classification < ApplicationRecord
  enum group: [:mixed, :business, :personal]

  validates :group, presence: true
  validates :name, uniqueness: {scope: :group}

  def display_name
    [group.to_s.titlecase, name.titlecase].join('::')
  end
end
