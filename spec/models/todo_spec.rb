require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(100) }
    it { should validate_length_of(:description).is_at_most(1000) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array(['pending', 'in_progress', 'completed']) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:todo)).to be_valid
    end
  end

  describe 'creating todos' do
    context 'with valid attributes' do
      it 'creates a new todo' do
        todo = Todo.new(
          title: 'Valid title',
          description: 'Valid description',
          status: 'pending'
        )
        expect(todo).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a title' do
        todo = Todo.new(status: 'pending')
        expect(todo).not_to be_valid
        expect(todo.errors[:title]).to include("can't be blank")
      end

      it 'is invalid with a too short title' do
        todo = Todo.new(title: 'ab', status: 'pending')
        expect(todo).not_to be_valid
        expect(todo.errors[:title]).to include('is too short (minimum is 3 characters)')
      end

      it 'is invalid with an invalid status' do
        todo = Todo.new(title: 'Valid title', status: 'invalid')
        expect(todo).not_to be_valid
        expect(todo.errors[:status]).to include('is not included in the list')
      end
    end
  end
end
