require 'spec_helper'

describe Projects::RawController do
  let(:public_project) { create(:project, :public) }

  describe "#show" do
    context 'regular filename' do
      let(:id) { 'master/README.md' }

      it 'delivers ASCII file' do
        get(:show,
            namespace_id: public_project.namespace.to_param,
            project_id: public_project.to_param,
            id: id)

        expect(response.status).to eq(200)
        expect(response.header['Content-Type']).to eq('text/plain; charset=utf-8')
        expect(response.header['Content-Disposition']).
            to eq("inline")
      end
    end
  end
end
