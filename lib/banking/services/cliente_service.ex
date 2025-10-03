defmodule Banking.Services.ClienteService do
  alias Banking.Repo.ClienteRepository
  alias Banking.Schemas.Cliente

  # create - com verificação de cpf_cnpj unico
  def create_cliente(attrs \\ %{}) do
    if cpf_cnpj_exists?(attrs["cpf_cnpj"]) do
      {:error, "CPF/CNPJ ja cadastrado"}
    else
      ClienteRepository.create_cliente(attrs)
    end
  end

  # read - listar clientes
  def list_clientes do
    ClienteRepository.list_clientes()
  end

  # read - buscar cliente por id - com tratamento de erro
  def get_cliente_cpf_cnpj(cpf_cnpj) do
    try do
      ClienteRepository.get_cliente_cpf_cnpj(cpf_cnpj)
    rescue
      _ -> {:error, "Erro ao buscar cliente."}
    end
  end

  # update
  def update_cliente(%Cliente{} = cliente, attrs) do
    ClienteRepository.update_cliente(cliente, attrs)
  end

  # delete
  def delete_cliente_by_cpf_cnpj(cpf_cnpj) do
    ClienteRepository.delete_cliente_by_cpf_cnpj(cpf_cnpj)
  end

  defp cpf_cnpj_exists?(cpf_cnpj) do
    ClienteRepository.cpf_cnpj_exists?(cpf_cnpj)
  end
end
