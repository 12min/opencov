defmodule Opencov.Factory do
  use ExMachina.Ecto, repo: Opencov.Repo

  def factory(:project) do
    %Opencov.Project{
      name: sequence(:name, &("name-#{&1}")),
      base_url: sequence(:base_url, &("https://github.com/tuvistavie/name-#{&1}"))
    }
  end

  def factory(:build) do
    %Opencov.Build{
      build_number: sequence(:build_number, &(&1)),
      project: build(:project)
    }
  end

  def factory(:job) do
    %Opencov.Job{
      job_number: sequence(:job_number, &(&1)),
      build: build(:build)
    }
  end

  def factory(:file) do
    %Opencov.File{
      name: sequence(:name, &("file-#{&1}")),
      source: "return 0",
      coverage_lines: [],
      job: build(:job)
    }
  end

  def with_project(build) do
    project = create(:project)
    %{build | project_id: project.id}
  end
end