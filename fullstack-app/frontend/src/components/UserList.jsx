import React, { useEffect, useState } from 'react';
import axios from 'axios';

const UserList = () => {
    const [alunos, setAlunos] = useState([]);

    useEffect(() => {
        axios
            .get(`${import.meta.env.VITE_API_URL}/alunos`)
            .then(response => setAlunos(response.data))
            .catch(error => console.error('Erro ao buscar alunos:', error));
    }, []);

    return (
        <ul>
            {alunos.map(aluno => (
                <li key={aluno.id}>
                    <strong>{aluno.nome}</strong> – {aluno.curso}
                </li>
            ))}
        </ul>
    );
};

export default UserList;
