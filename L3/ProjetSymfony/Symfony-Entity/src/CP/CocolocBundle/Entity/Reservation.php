<?php

namespace CP\CocolocBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Reservation
 *
 * @ORM\Table(name="reservation")
 * @ORM\Entity(repositoryClass="CP\CocolocBundle\Repository\ReservationRepository")
 */
class Reservation
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;


    /**
     * @var \DateTime
     *
     * @ORM\Column(name="date", type="datetime")
     */
    private $date;


    /**
    *@ORM\ManyToOne(targetEntity="Annonce", inversedBy="reservations", cascade={"persist"})
    *@ORM\JoinColumn(nullable=true,onDelete="CASCADE")
    */

    private $annonce;


    /**
    *@ORM\ManyToOne(targetEntity="CP\UserBundle\Entity\User", inversedBy="reservations", cascade={"persist"})
    *@ORM\JoinColumn(nullable=true,onDelete="CASCADE")
    */

    private $user;


        /**
     * @var int
     *
     * @ORM\Column(name="statut", type="integer")
     */
    private $statut;
    // sert a déterminer si la réservation est accepté ou non 0 en attente 1 accepté


    public function __construct(){
        $this->date = new \Datetime();
        $this->statut = 0;
    }

    public function getAnnonce(){
        return $this->annonce;
    }

    public function setAnnonce($annonce){
        $this->annonce = $annonce;
    }



    public function getStatut(){
        return $this->statut;
    }

    public function setStatut($statut){
        $this->statut = $statut;
    }


    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set date
     *
     * @param \DateTime $date
     *
     * @return Reservation
     */
    public function setDate($date)
    {
        $this->date = $date;

        return $this;
    }

    /**
     * Get date
     *
     * @return \DateTime
     */
    public function getDate()
    {
        return $this->date;
    }


    public function setUser($user){
        $this->user = $user;
    }

    public function getUser(){
        return $this->user;
    }
}

