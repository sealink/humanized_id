require 'spec_helper'

describe HumanizedId::Humanizer do
  let(:humanizer) { HumanizedId::Humanizer.new params }

  context 'when generating humanized id' do
    let(:generated_id) { humanizer.generate_humanized_id }
    let(:params) { { id: 1_234_567 } }
    let(:expected_id) { '6RDFD' }

    context 'testing various ids' do
      context 'non integer id' do
        let(:params) { { id: 'CDFGHKMN' } }
        it 'should raise an error' do
          expect { generated_id }.to raise_error(HumanizedId::Error, 'id is not an integer')
        end
      end

      context 'with an integer id' do
        it 'should produce expected id' do
          expect(generated_id).to eq expected_id
        end
      end
    end

    context 'testing various lengths' do
      context 'with greater length' do
        let(:params) { super().merge(length: 15) }
        it 'should produce expected id with correct number of padding' do
          expect(generated_id).to eq(('2' * 10) + expected_id)
        end
      end

      context 'with shorter length' do
        let(:params) { super().merge(length: 3) }
        it 'should produce original expected id' do
          expect(generated_id).to eq expected_id
        end
      end
    end

    context 'with prefix added' do
      let(:params) { super().merge(prefix: 'abc') }
      it 'should generate id with prefix added' do
        expect(generated_id).to eq(params[:prefix] + expected_id)
      end
    end
  end
end
