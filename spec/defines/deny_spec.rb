require 'spec_helper'

describe 'tcpwrappers::deny', type: :define do
  let :title do
    'tcpwrappers deny'
  end
  let(:facts) { { 'osfamily' => 'Debian' } }
  let(:pre_condition) { 'include tcpwrappers' }
  let(:params) do
    {
      'name' => 'Test',
      'service' => 'test',
      'address' => '10.11.12.13',
    }
  end

  context 'with ipv4 address' do
    it { is_expected.to compile }
  end

  context 'with hostname' do
    let(:params) do
      super().merge('address' => 'host.example.com')
    end

    it { is_expected.to compile }
  end

  context 'with ipv6 address' do
    let(:params) do
      super().merge('address' => '[dead::beef]/64')
    end

    it { is_expected.to compile }
  end

  context 'with invalid address' do
    let(:params) do
      super().merge('address' => 'dead:beef')
    end

    it { is_expected.to compile.and_raise_error(%r{does not match}) }
  end
end
