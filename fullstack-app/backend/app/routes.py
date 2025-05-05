from flask import Blueprint, request, jsonify
from .models import Aluno
from . import db

bp = Blueprint('main', __name__)

@bp.route('/alunos', methods=['GET'])
def listar_alunos():
    alunos = Aluno.query.all()
    return jsonify([{"id": a.id, "nome": a.nome, "curso": a.curso} for a in alunos])

@bp.route('/alunos', methods=['POST'])
def criar_aluno():
    data = request.json
    novo = Aluno(nome=data['nome'], curso=data['curso'])
    db.session.add(novo)
    db.session.commit()
    return jsonify({"message": "Aluno criado com sucesso!"}), 201
