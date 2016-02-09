require 'spec_helper'

describe HumanizedId::Humanizer do
  let(:params) {
    {
      id: 1_234_567,
      source_charset: '1234567890abcdefgh',
      target_charset: '1234567890abcdefgh'
    }
  }
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
    # context 'with target charset smaller than source charset' do

    # end
  end
end
