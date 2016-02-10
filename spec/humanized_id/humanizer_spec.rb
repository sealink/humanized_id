require 'spec_helper'

describe HumanizedId::Humanizer do
  let(:params) {
    {
      id: 102_421_311_311,
      source_charset: '1234567890abcdefgh',
      target_charset: '1234567890abcdefgh'
    }
  }
  let(:converted_id_without_padding) { '9555a146b' }
  let(:converted_id_with_default_padding) { ('1' * 3) + converted_id_without_padding }
  let(:humanizer) { HumanizedId::Humanizer.new params }

  context 'when validating charset' do
    context 'with target charset greater than source charset' do
      let(:params) { super().merge(source_charset: '1234567890abc') }
      it 'should fail with HumanizedId::Error' do
        expect { humanizer }.to raise_error(
          HumanizedId::Error,
          "Maximum length of allowed characters is #{params[:source_charset].length}"
        )
      end
    end
    context 'with target charset smaller than source charset' do
      let(:params) { super().merge(target_charset: '123245') }
      it 'should validate correctly' do
        expect(humanizer).to be_a(HumanizedId::Humanizer)
      end
    end
  end

  context 'when generating humanized id' do
    let(:generated_id) { humanizer.generate_humanized_id }

    context 'with minimum required params' do
      it 'should create id based on the given charset and padded to original length' do
        expect(generated_id).to eq(converted_id_with_default_padding)
      end
    end

    context 'with generated_length added' do
      context 'with greater generated_length' do
        let(:params) { super().merge(generated_length: 15) }
        it 'should add additional padding to meet required generated_length' do
          expect(generated_id).to eq(('1' * 3) + converted_id_with_default_padding)
        end
      end
      context 'with smaller generated_length' do
        let(:params) { super().merge(generated_length: 2) }
        it 'should trim the id to required length' do
          expect(generated_id).to eq converted_id_without_padding[0..1]
        end
      end
    end

    context 'with prefix added' do
      let(:params) { super().merge(prefix: 'abc') }
      it 'should generate id with padding for default generated_length and then prefix added' do
        expect(generated_id).to eq(params[:prefix] + converted_id_with_default_padding)
      end
    end

    context 'working with an invalid target_charset' do
      let(:params) { super().merge(target_charset: 'a') }
      it 'should generate an invalid target charset error' do
        expect { generated_id }.to raise_error(
          HumanizedId::Error,
          "Unable to do base conversion of id: #{params[:id]} " \
          "into base: #{params[:target_charset].length}"
        )
      end
    end
  end
end
