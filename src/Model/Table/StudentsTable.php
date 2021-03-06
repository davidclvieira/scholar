<?php

namespace App\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;
use Cake\ORM\RulesChecker;

class StudentsTable extends Table
{

    public function initialize(array $config)
    {
        parent::initialize($config);
        $this->belongsTo('Users');
    }

    public function validationDefault(Validator $validator)
    {
        $validator
            ->notEmpty('name')
            ->requirePresence('name', 'Digite o nome do aluno')

            ->notEmpty('telephone')
            ->requirePresence('telephone', 'Digite o telefone do aluno')

            ->notEmpty('email')
            ->requirePresence('email', 'Digite o email do aluno');

        return $validator;
    }

    public function buildRules(RulesChecker $rules)
    {
        $rules->add($rules->isUnique(['email'], 'Alguém já possui este email cadastrado'));

        return $rules;
    }
}
