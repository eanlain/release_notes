FactoryGirl.define do
  factory :release_note, class: ReleaseNotes.release_note_model do
    sequence(:version) { |n| "0.#{n}.0" }
    sequence(:markdown) { |n| "#{n} Some Markdown content here..." }
  end
end
