# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:subject) { build(:user) }

  context 'when user is new' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should_not validate_length_of(:username).is_at_least(5) }

    describe '#normalize_email' do
      before do
        subject.email = 'CAPITALS@world.com'
      end

      it 'should make the email lowercase' do
        expect { subject.valid? }.to change { subject.email }
          .from('CAPITALS@world.com')
          .to('capitals@world.com')
      end
    end

    describe '#set_default_username' do
      it 'should set username as the first part of email' do
        expect { subject.save }.to change { subject.username }
          .from(nil)
          .to(subject.email.split('@').first)
      end

      context 'even if default username has less than 5 characters' do
        before do
          subject.email = 'a@username.com'
        end

        it 'should get saved' do
          expect(subject.save).to be_truthy
        end
      end
    end
  end

  context 'when user is old' do
    before do
      subject.save
    end

    it { should validate_length_of(:username).is_at_least(5) }
  end

  context 'when user is old with short default username' do
    before do
      subject.email = 'a@username.com'
      subject.save
    end

    context 'changing password' do
      before do
        subject.password = 'abcdefgh'
        subject.password_confirmation = 'abcdefgh'
      end
      it 'should succeed' do
        expect(subject.save).to be_truthy
      end
    end
  end
end
