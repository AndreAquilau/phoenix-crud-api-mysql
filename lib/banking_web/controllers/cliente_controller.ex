defmodule BankingWeb.ClienteController do
  use BankingWeb, :controller

  alias Banking.Services.ClienteService

  # GET /clientes
  def index(conn, _params) do
    ClienteService.list_clientes()
    |> case do
      [] ->
        conn
        |> put_status(:not_found)
        |> json(%{message: "Nenhum cliente cadastrado."})

      list ->
        clientes =
          list
          |> Enum.map(fn cliente ->
            %{
              id: cliente.id_cliente,
              nome_completo: cliente.nome_completo,
              cpf_cnpj: cliente.cpf_cnpj,
              data_nascimento: cliente.data_nascimento,
              email: cliente.email,
              telefone: cliente.telefone,
              endereco: cliente.endereco,
              cidade: cliente.cidade,
              estado: cliente.estado,
              status_cliente: cliente.status_cliente
            }
          end)

        conn
        |> put_status(:ok)
        |> json(clientes)
    end
  end

  # POST /clientes
  def create(conn, params) do
    try do
      case ClienteService.create_cliente(params) do
        {:ok, cliente} ->
          cliente = %{
            id: cliente.id_cliente,
            nome_completo: cliente.nome_completo,
            cpf_cnpj: cliente.cpf_cnpj,
            data_nascimento: cliente.data_nascimento,
            email: cliente.email,
            telefone: cliente.telefone,
            endereco: cliente.endereco,
            cidade: cliente.cidade,
            estado: cliente.estado,
            status_cliente: cliente.status_cliente
          }

          conn
          |> put_status(:created)
          |> json(cliente)

        {:error, reason} ->
          conn
          |> put_status(:bad_request)
          |> json(%{error: reason})

        _ ->
          conn
          |> put_status(:internal_server_error)
          |> json(%{error: "Erro ao criar cliente."})
      end
    rescue
      error ->
        IO.inspect(error, label: "Erro no ClienteController.create")

        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Erro ao processar requisicao."})
    end
  end

  def get_cliente_cpf_cnpj(conn, %{"cpf_cnpj" => cpf_cnpj}) do
    ClienteService.get_cliente_cpf_cnpj(cpf_cnpj)
    |> case do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Cliente nao encontrado."})
      {:error, _reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Erro ao buscar cliente."})

      cliente ->
        cliente = %{
          id: cliente.id_cliente,
          nome_completo: cliente.nome_completo,
          cpf_cnpj: cliente.cpf_cnpj,
          data_nascimento: cliente.data_nascimento,
          email: cliente.email,
          telefone: cliente.telefone,
          endereco: cliente.endereco,
          cidade: cliente.cidade,
          estado: cliente.estado,
          status_cliente: cliente.status_cliente
        }

        conn
        |> put_status(:ok)
        |> json(cliente)
    end
  end

  def update(conn, %{"cpf_cnpj" => cpf_cnpj} = params) do
    case ClienteService.get_cliente_cpf_cnpj(cpf_cnpj) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Cliente nao encontrado."})

      cliente ->
        case ClienteService.update_cliente(cliente, params) do
          {:ok, updated_cliente} ->
            updated_cliente = %{
              id: updated_cliente.id_cliente,
              nome_completo: updated_cliente.nome_completo,
              cpf_cnpj: updated_cliente.cpf_cnpj,
              data_nascimento: updated_cliente.data_nascimento,
              email: updated_cliente.email,
              telefone: updated_cliente.telefone,
              endereco: updated_cliente.endereco,
              cidade: updated_cliente.cidade,
              estado: updated_cliente.estado,
              status_cliente: updated_cliente.status_cliente
            }

            conn
            |> put_status(:ok)
            |> json(updated_cliente)

          {:error, reason} ->
            conn
            |> put_status(:bad_request)
            |> json(%{error: reason})

          _ ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Erro ao atualizar cliente."})
        end
    end
  end


  def delete(conn, %{"cpf_cnpj" => cpf_cnpj}) do
    case ClienteService.get_cliente_cpf_cnpj(cpf_cnpj) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Cliente nao encontrado."})

      _cliente ->
        case ClienteService.delete_cliente_by_cpf_cnpj(cpf_cnpj) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(%{message: "Cliente deletado com sucesso."})

          {:error, reason} ->
            conn
            |> put_status(:bad_request)
            |> json(%{error: reason})

          _ ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Erro ao deletar cliente."})
        end
    end
  end
end
