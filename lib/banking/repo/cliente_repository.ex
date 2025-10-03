defmodule Banking.Repo.ClienteRepository do
  import Ecto.Query, warn: false
  alias Banking.Repo
  alias Banking.Schemas.Cliente

  # create
  def create_cliente(attrs \\ %{}) do
    %Cliente{}
    |> Cliente.changeset(attrs)
    |> Repo.insert()
  end

  # read - listar clientes
  def list_clientes do
    Cliente
    |> Repo.all()
  end

  # read - buscar cliente por id
  def get_cliente_cpf_cnpj(cpf_cnpj),
    do: Repo.one(from c in Cliente, where: c.cpf_cnpj == ^cpf_cnpj)

  # update
  def update_cliente(%Cliente{} = cliente, attrs) do
    cliente
    |> Cliente.changeset(attrs)
    |> Repo.update()
  end

  # delete
  def delete_cliente_by_cpf_cnpj(cpf_cnpj) do
    case get_cliente_cpf_cnpj(cpf_cnpj) do
      nil -> {:error, :not_found}
      cliente -> Repo.delete(cliente)
    end
  end

  # verifica se cpf_cnpj ja existe
  def cpf_cnpj_exists?(cpf_cnpj) do
    query = from c in Cliente, where: c.cpf_cnpj == ^cpf_cnpj, select: c.id_cliente
    Repo.exists?(query)
  end
end
