RSpec.describe SplitUserVariantsController, type: :controller do
  it_behaves_like 'a controller authenticating'
  it_has_behavior_of 'an authenticated user' do
    it_behaves_like 'a controller authorizing'
  end
  it_behaves_like 'a controller paginating'
  it_behaves_like 'a controller sorting', attributes: [], default: :id
  it_behaves_like 'a controller filtering', attributes: [:split_id, :'projects.slug']
  it_has_behavior_of 'an authenticated user' do
    let(:current_user){ resource_instance.user }
    it_behaves_like 'a controller rendering'
  end

  describe '#index' do
    subject{ get :index, params: params }

    context 'when assignable' do
      it_has_behavior_of 'an authenticated user' do
        let(:params){ { filter: {'projects.slug' => slug } } }

        context 'when the project exists' do
          let(:project){ create :project }
          let(:slug){ project.slug }

          let!(:splits) do
            create_list :split_with_variants, 2, project: project, state: 'active'
          end

          before(:each) do
            expect(Project).to receive(:find_by_slug!).with(project.slug).and_return project
            expect(project).to receive_message_chain('splits.active').and_return splits
          end

          it{ is_expected.to be_ok }

          it 'should assign the user' do
            splits.each do |split|
              expect(split).to receive(:assign_user).with current_user
            end
            subject
          end
        end

        context 'when the project does not exist' do
          let(:slug){ 'nope' }
          it{ is_expected.to be_missing }
        end
      end
    end

    context 'when not assignable' do
      it_has_behavior_of 'an authenticated user' do
        let(:params){ { } }
        it 'should not assign the user' do
          expect(controller).to_not receive :ensure_assigned
          subject
        end
      end
    end
  end
end
