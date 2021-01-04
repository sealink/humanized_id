# frozen_string_literal: true
require 'spec_helper'

describe HumanizedId do
  let(:expected_params) { params }

  context 'when calling humanize' do
    let(:params) { { id: 1_234_567 } }
    let(:humanize) { HumanizedId.humanize(**params) }

    let(:humanizer_instance) { double }
    let(:humanizer) { double }

    before do
      allow(humanizer).to receive(:new).and_return(humanizer_instance)
      allow(humanizer_instance).to receive(:generate_humanized_id)
      stub_const('HumanizedId::Humanizer', humanizer)
    end

    shared_examples 'a delegated call to humanizer' do
      before do
        humanize
      end

      specify do
        expect(humanizer).to have_received(:new).with(expected_params)
      end
      specify do
        expect(humanizer_instance).to have_received(:generate_humanized_id).with(no_args)
      end
    end

    context 'with minimum required values' do
      let(:expected_params) { super().merge(min_length: nil, prefix: '') }
      it_behaves_like 'a delegated call to humanizer'
    end

    context 'with all params passed in' do
      let(:params) { super().merge(min_length: 20, prefix: 'test') }
      it_behaves_like 'a delegated call to humanizer'
    end
  end

  context 'when calling generate_random' do
    let(:params) { {} }
    let(:generate_random) { HumanizedId.generate_random(**params) }

    let(:rand_generator_instance) { double }
    let(:rand_generator) { double }

    before do
      allow(rand_generator).to receive(:new).and_return(rand_generator_instance)
      allow(rand_generator_instance).to receive(:generate_random_humanized_id)
      stub_const('HumanizedId::RandGenerator', rand_generator)
    end

    shared_examples 'a delegated call to rand generator' do
      before do
        generate_random
      end

      specify do
        expect(rand_generator).to have_received(:new).with(expected_params)
      end
      specify do
        expect(rand_generator_instance)
          .to have_received(:generate_random_humanized_id).with(no_args)
      end
    end

    context 'with minimum required values' do
      let(:expected_params) {
        super().merge(prefix: '', length: HumanizedId::DEFAULT_GENERATION_LENGTH)
      }
      it_behaves_like 'a delegated call to rand generator'
    end

    context 'with all values passed in' do
      let(:params) { super().merge(prefix: 'test', length: 3) }
      it_behaves_like 'a delegated call to rand generator'
    end
  end
end
