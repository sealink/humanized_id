require 'spec_helper'

describe HumanizedId do
  context 'when calling humanize' do
    let(:params) { { id: '22FARTYFART' } }
    let(:humanized_id) { HumanizedId.humanize params }

    context 'with minimum required values' do
      it 'should return a different humanized id of same size' do
        expect(humanized_id).not_to eq params[:id]
        expect(humanized_id.length).to eq params[:id].length
      end
    end
    context 'with all params passed in' do
      let(:params) {
        {
          id: '22FARTYFART',
          length: 20,
          prefix: 'test'
        }
      }
      it 'should humanize id with appropriate length and prefix' do
        expect(humanized_id).to match /#{params[:prefix]}#{HumanizedId::CHARACTERSET}{20}/
        expect(humanized_id).not_to eq(params[:prefix] + params[:id])
        expect(humanized_id.size).to eq(params[:prefix].length + params[:length])
        expect(humanized_id.slice(0, params[:prefix].length)).to eq params[:prefix]
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
        expect(random_id).to match /#{params[:prefix]}#{HumanizedId::CHARACTERSET}{3}/
      end
    end
  end
end
