require 'spec_helper'

describe HumanizedId do
  let(:params) { { id: 102_421_311_311 } }
  let(:converted_id_without_padding) { 'YDYT92MZ' }
  let(:humanized_id) { HumanizedId.humanize params }

  context 'when calling humanize' do
    context 'with minimum required values' do
      it 'should humanize the id padded to original length' do
        expect(humanized_id).to eq(('2' * 4) + converted_id_without_padding)
      end
    end
    context 'with all params passed in' do
      let(:params) {
        {
          id: 102_421_311_311,
          generated_length: 20,
          prefix: 'test',
          source_charset: '1234567890abcdefgh',
          target_charset: '1234567890abcdefgh'
        }
      }
      let(:converted_id_without_padding) { '9555a146b' }
      it 'should humanize id appropriately' do
        expect(humanized_id).to eq(params[:prefix] + ('1' * 11) + converted_id_without_padding)
      end
    end
  end
end
