import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_DADOS_CADASTRAIS_NOME,
  CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO,
  CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_LINGUAGENS,
  CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_SALARIO,
  CHAVE_NOME_USUARIO,
  CHAVE_ALTURA,
  CHAVE_RECEBER_NOTIFICACOES,
  CHAVE_MODO_ESCURO,
  CHAVE_NUMERO_ALEATORIO,
  CHAVE_QTD_CLICKS,
}

class AppStorage {
  Future<void> setDadosCadastraisNome(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString(), nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return await _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString());
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime data) async {
    await _setString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString(), data.toString());
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return await _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString());
  }

  Future<void> setDadosCadastraisNivelExperiencia(String nivelExperiencia) async {
    await _setString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString(), nivelExperiencia);
  }

  Future<String> getDadosCadastraisNivelExperiencia() async {
    return await _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString());
  }

  Future<void> setDadosCadastraisLinguagens(List<String> linguagens) async {
    await _setStringList(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString(), linguagens);
  }

  Future<List<String>> getDadosCadastraisLinguagens() async {
    return await _getStringList(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString());
  }

  Future<void> setDadosCadastraisTempoExperiencia(int tempoExperiencia) async {
    await _setInt(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(), tempoExperiencia);
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return await _getInt(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString());
  }

  Future<void> setDadosCadastraisSalario(double salario) async {
    await _setDouble(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString(), salario);
  }

  Future<double> getDadosCadastraisSalario() async {
    return await _getDouble(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString());
  }

  Future<void> setConfiguracoesNome(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString(), nome);
  }

  Future<String> getConfiguracoesNome() async {
    return await _getString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString());
  }

  Future<void> setConfiguracoesAltura(double altura) async {
    await _setDouble(STORAGE_CHAVES.CHAVE_ALTURA.toString(), altura);
  }

  Future<double> getConfiguracoesAltura() async {
    return await _getDouble(STORAGE_CHAVES.CHAVE_ALTURA.toString());
  }

  Future<void> setConfiguracoesReceberNotificacoes(bool receberNotificacoes) async {
    await _setBool(STORAGE_CHAVES.CHAVE_RECEBER_NOTIFICACOES.toString(), receberNotificacoes);
  }

  Future<bool> getConfiguracoesReceberNotificacoes() async {
    return await _getBool(STORAGE_CHAVES.CHAVE_RECEBER_NOTIFICACOES.toString());
  }

  Future<void> setConfiguracoesTemaEscuro(bool temaEscuro) async {
    await _setBool(STORAGE_CHAVES.CHAVE_MODO_ESCURO.toString(), temaEscuro);
  }

  Future<bool> getConfiguracoesTemaEscuro() async {
    return await _getBool(STORAGE_CHAVES.CHAVE_MODO_ESCURO.toString());
  }
  
  Future<void> setNumeroAleatorio(int numeroAleatorio) async {
    await _setInt(STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString(), numeroAleatorio);
  }

  Future<int> getNumeroAleatorio() async {
    return await _getInt(STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString());
  }

  Future<void> setQtdClicks(int qtdClicks) async {
    await _setInt(STORAGE_CHAVES.CHAVE_QTD_CLICKS.toString(), qtdClicks);
  }

  Future<int> getQtdClicks() async {
    return await _getInt(STORAGE_CHAVES.CHAVE_QTD_CLICKS.toString());
  }

  // Globals Methods GET e SET
  Future<void> _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getString(chave) ?? '';
  }

  Future<void> _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();

    storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getStringList(chave) ?? [];
  }

  Future<void> _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getInt(chave) ?? 0;
  }

  Future<void> _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getDouble(chave) ?? 0;
  }

  Future<void> _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getBool(chave) ?? false;
  }
}