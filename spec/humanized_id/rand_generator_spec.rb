# frozen_string_literal: true
require 'spec_helper'

describe HumanizedId::RandGenerator do
  let(:params) { { length: 24 } }
  let(:rand_generator) { HumanizedId::RandGenerator.new params }
  let(:rand_humanized_id) { rand_generator.generate_random_humanized_id }

  context 'when generating random humanized id' do
    context 'with only a length specified' do
      it 'should generate random humanized id at required length' do
        expect(rand_humanized_id.length).to eq params[:length]
      end
    end

    context 'with prefix added' do
      let(:params) { super().merge(prefix: 'abc') }
      it 'should generate random humanized id at required length plus a prefix' do
        expect(rand_humanized_id[0..(params[:prefix].length - 1)]).to eq params[:prefix]
      end
    end
  end
end
