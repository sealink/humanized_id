require 'spec_helper'

describe HumanizedId do
  context 'when calling humanize' do
    let(:params) { { id: 1_234_567 } }
    let(:expected_id) { '6RDFD' }
    let(:humanized_id) { HumanizedId.humanize params }

    context 'with minimum required values' do
      it 'should return expected id' do
        expect(humanized_id).to eq expected_id
      end
    end
    context 'with all params passed in' do
      let(:params) {
        {
          id: 1_234_567,
          min_length: 20,
          prefix: 'test'
        }
      }
      it 'should humanize id with appropriate min_length and prefix' do
        expect(humanized_id).to eq(params[:prefix] + ('2' * 15) + expected_id)
      end
    end
  end

  context 'when calling generate_random' do
    let(:params) { {} }
    let(:random_id) { HumanizedId.generate_random params }

    context 'with minimum required values' do
      it 'should produce random id of default length' do
        expect(random_id.length).to eq HumanizedId::DEFAULT_GENERATION_LENGTH
      end
    end

    context 'with all values passed in' do
      let(:params) {
        {
          prefix: 'test',
          length: 3
        }
      }
      it 'should produce random id with requested length and prefix' do
        expect(random_id.length).to eq(params[:prefix].length + params[:length])
        expect(random_id[0..(params[:prefix].length - 1)]).to eq params[:prefix]
        expect(random_id).to match(/#{params[:prefix]}#{HumanizedId::CHARSET}{3}/)
      end
    end
  end
end
