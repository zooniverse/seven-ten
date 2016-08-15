RSpec.describe Project, type: :model do
  context 'validating' do
    it 'should require a slug' do
      without_slug = build :project, slug: nil
      expect(without_slug).to fail_validation slug: "can't be blank"
    end
  end
end
