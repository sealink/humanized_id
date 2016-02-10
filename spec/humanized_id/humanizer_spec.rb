require 'spec_helper'

describe HumanizedId::Humanizer do
  let(:humanizer) { HumanizedId::Humanizer.new params }

  context 'when generating humanized id' do
    let(:generated_id) { humanizer.generate_humanized_id }

    context 'testing various ids' do
      context 'with human friendly characters' do
        let(:params) { { id: 'CDFGHKMN' } }
        it 'should return original string' do
          expect(generated_id).to eq params[:id]
        end
      end

      context 'with non human friendly characters' do
        let(:params) { { id: '22FARTYFART' } }
        it 'should return a different humanized id of same size' do
          expect(generated_id).not_to eq params[:id]
          expect(generated_id.length).to eq params[:id].length
        end
      end

      context 'with numerical id' do
        let(:params) { { id: 123_456_789 } }
        it 'should return a sanitised id of same size and structure' do
          expect(generated_id).to match(/.234.67.9/)
          expect(generated_id.length).to eq params[:id].to_s.length
        end
      end
    end

    context 'testing various lengths' do
      let(:params) { { id: 'CDFGHKMN' } } # Human-friendly id, to isolate length testing
      context 'with greater length' do
        let(:params) { super().merge(length: 15) }
        it 'should add additional padding to meet required length' do
          expect(generated_id).to eq(('2' * 7) + params[:id])
        end
      end
      context 'with smaller length' do
        let(:params) { super().merge(length: 2) }
        it 'should trim the id to required length' do
          expect(generated_id).to eq 'MN'
        end
      end
    end

    context 'with prefix added' do
      let(:params) { { id: 'CDFGHKMN', prefix: 'abc' } }
      it 'should generate id with prefix added' do
        expect(generated_id).to eq(params[:prefix] + params[:id])
      end
    end
  end
end
