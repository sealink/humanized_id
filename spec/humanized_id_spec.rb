require 'spec_helper'

describe HumanizedId do
  context 'when calling humanize' do
    let(:params) { { id: 102_421_311_311 } }
    let(:converted_id_without_padding) { 'YDYT92MZ' }
    let(:humanized_id) { HumanizedId.humanize params }

    context 'with minimum required values' do
      it 'should humanize the id padded to original length' do
        expect(humanized_id).to eq(('2' * 4) + converted_id_without_padding)
      end
    end
    context 'with all params passed in' do
      let(:params) {
        {
          id: 102_421_311_311,
          length: 20,
          prefix: 'test'
        }
      }
      let(:converted_id_without_padding) { 'YDYT92MZ' }
      it 'should humanize id appropriately' do
        expect(humanized_id).to eq(params[:prefix] + ('2' * 12) + converted_id_without_padding)
      end
    end
  end

  context 'when calling generate_random' do
    let(:params) { {} }
    let(:random_id) { HumanizedId.generate_random params }

    context 'with minimum required values' do
      it 'should produce random id of default length' do
        expect(random_id.length).to eq HumanizedId.default_random_length
      end
    end

    context 'with all values passed in' do
      let(:params) {
        {
          prefix: 'test',
          length: 3,
          real_rand: true
        }
      }
      it 'should produce random id with requested length and prefix' do
        expect(random_id.length).to eq(params[:prefix].length + params[:length])
        expect(random_id[0..(params[:prefix].length - 1)]).to eq params[:prefix]
      end
    end
  end
end
