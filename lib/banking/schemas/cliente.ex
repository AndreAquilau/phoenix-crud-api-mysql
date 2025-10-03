defmodule Banking.Schemas.Cliente do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id_cliente, :id, autogenerate: true}
  schema "clientes" do
    field :nome_completo, :string
    field :cpf_cnpj, :string
    field :data_nascimento, :date
    field :email, :string
    field :telefone, :string
    field :endereco, :string
    field :cidade, :string
    field :estado, :string
    field :status_cliente, Ecto.Enum, values: [:Ativo, :Inativo], default: :Ativo
  end

  def changeset(cliente, attrs) do
    cliente
    |> cast(attrs, [
      :nome_completo,
      :cpf_cnpj,
      :data_nascimento,
      :email,
      :telefone,
      :endereco,
      :cidade,
      :estado,
      :status_cliente
    ])
    |> validate_required([:nome_completo, :cpf_cnpj])
    |> unique_constraint(:cpf_cnpj)
  end
end
