require 'rails_helper'

RSpec.describe Fib, type: :model do
  let!(:fib) { create(:fib, size: 10) }
  let(:unsaved_fib) { build(:fib, size: 4) }
  let(:expected_result) { [0, 1, 1, 2, 3, 5, 8, 13, 21, 34] }
  let(:expected_result_for_unsaved) { [0, 1, 1, 2] }

  describe '#size' do
    it { should validate_presence_of(:size) }
    it { should validate_numericality_of(:size).only_integer }
  end

  describe '#generated_fibs' do
    context "when fib is saved to database" do
      it "returns the generated sequence" do
        expect(fib.generated_fibs).to eq(expected_result)
      end
    end

    context "with unsaved fib" do
      it { expect(unsaved_fib.generated_fibs).to be_nil }
    end
  end

  describe '#generate' do
    context "when sequence is present in database" do
      before(:each) do
        allow_any_instance_of(Fib).to receive(:generate_fibs) { raise Exception }
      end

      it "returns already generated sequence" do
        expect(unsaved_fib.generate).to eq(expected_result_for_unsaved)
      end

      it "doesn't call generate_fibs" do
        expect { unsaved_fib.generate }.not_to raise_error
      end
    end
  end

  describe '#generate_fibs' do
    it "sets the generated_fibs" do
      unsaved_fib.send(:generate_fibs, unsaved_fib.size)
      expect(unsaved_fib.generated_fibs).to eq(expected_result_for_unsaved)
    end
  end

  describe '#already_generated' do
    context "when fibonacci sequence is present in database" do
      it "sets generated_fibs to one from the db" do
        unsaved_fib.send(:already_generated)
        expect(unsaved_fib.generated_fibs).to eq(expected_result_for_unsaved)
      end
    end

    context "when absent" do
      it { expect(unsaved_fib.generated_fibs).to be_nil }
    end
  end

  describe '#known_fibs_sum_of_squares' do
    let(:expected_result) { 1870 }

    context 'when there are stored numbers' do
      it 'returns the sum of the squared values for all known fibs' do
        expect(fib.known_fibs_sum_of_squares).to eq(expected_result)
      end
    end

    context 'when there are no stored numbers' do
      it 'returns 0' do
        expect(unsaved_fib.known_fibs_sum_of_squares ).to eq(0)
      end
    end
  end

  describe '#is_known_fib?' do
    context 'when passed a fibonacci number that it has not stored' do
      it 'returns false' do
        expect(fib.is_known_fib?(55)).to eq(false)
      end
    end

    context 'when passed a number that has been stored' do
      it 'returns true' do
        expect(fib.is_known_fib?(34)).to eq(true)
      end
    end
  end

  describe '#all_fibs?' do
    context 'when passed an array of numbers that are all members of the the fibonacci sequence' do
      it 'returns true' do
        expect(fib.all_fibs?([0, 1, 1, 2, 3])).to eq(true)
      end
    end

    context 'when passed an array of numbers that where at least one is not a member of the sequence' do
      it 'returns false' do
        expect(fib.all_fibs?([0, 1, 1, 1, 3])).to eq(false)
      end
    end
  end

  describe '.find_generated_fibs' do
    context "when fibonacci sequence is present in database" do
      it "returns sequence if it's grater or equal to the given size" do
        expect(described_class.find_generated_fibs(4)).to eq(expected_result_for_unsaved)
      end

      it "cuts sequence to the given size" do
         expect(described_class.find_generated_fibs(4).size).to eq(4)
      end
    end

    context "when absent" do
      it { expect(described_class.find_generated_fibs(11)).to be_nil }
    end
  end
end
