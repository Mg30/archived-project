<?php

namespace CP\UserBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use FOS\UserBundle\Model\User as BaseUser;
use Doctrine\Common\Collections\ArrayCollection;
use CP\CocolocBundle\Entity\Annonce;
use CP\CocolocBundle\Entity\commentaire;
use CP\CocolocBundle\Entity\Reservation;
use Symfony\Component\Validator\Constraints as Assert;




/**
 * User
 *
 * @ORM\Table(name="user")
 * @ORM\Entity(repositoryClass="CP\UserBundle\Repository\UserRepository")
 */
class User extends BaseUser
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;


    /**
    *@ORM\OneToMany(targetEntity="CP\CocolocBundle\Entity\Annonce", mappedBy="user")
    */

    private $annonces;

    /**
    *@ORM\OneToMany(targetEntity="CP\CocolocBundle\Entity\commentaire", mappedBy="user")
    */

    private $commentaires;


        /**
    *@ORM\OneToMany(targetEntity="CP\CocolocBundle\Entity\Reservation", mappedBy="user")
    */

    private $reservations;

    /**
     * @ORM\Column(type="string")
     *
     * @Assert\NotBlank(message="Ajouter une image jpg")
     * @Assert\File(mimeTypes={ "image/jpeg" })
     */
    private $image;



  /**
     * @var string
     *
     * @ORM\Column(name="description", type="text",nullable=true)
     *
     */
    private $description;





    public function __construct(){
    	parent::__construct();
        $this->commentaires = new ArrayCollection();
        $this->reservations = new ArrayCollection();
        $this->annonces = new ArrayCollection();

    }


    public function addAnnonce(Annonce $annonce = null){
        $this->annonces [] = $annonce;
    }
    public function getAnnonce(){
        return $this->annonces;
    }

    public function addCommentaire(commentaire $commentaire){
        $this->commentaires [] = $commentaire;
    }

    public function addReservation(Reservation $reservation){
        $this->reservations [] = $reservation;
    }


        public function getCommentaire(){
        return $this->commentaires;
    }

        public function getReservation(){
        return $this->reservations;
    }


     public function getImage()
    {
        return $this->image;
    }

    public function setImage($image)
    {
        $this->image = $image;

        return $this;
    }


    public function getDescription(){
        return $this->description;
    }

        public function setDescription($description){
        $this->description = $description ;
        return $this;
    }


}

