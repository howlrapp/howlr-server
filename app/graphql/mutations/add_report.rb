class Mutations::AddReport < Mutations::BaseMutation
  argument :subject_id, ID, required: true
  argument :subject_type, String, required: true
  argument :description, String, required: false

  field :id, ID, null: false

  def resolve(subject_id:, subject_type:, description:)
    report = Report.new(
      reporter: context[:current_user],
      subject_id: subject_id,
      subject_type: subject_type,
      description: description,
    )

    raise Pundit::NotAuthorizedError unless ReportPolicy.new(context[:current_user], report).create?

    report.save!

    { id: report.id }
  end
end
